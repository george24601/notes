### Eval RAG

 Primarily, we are dealing with two distinct systems: the search system and the question answering (QA) system. It's common to see a lot of focus on evaluating the QA system, given its direct interaction with the end-user's queries. However, it's equally important to not overlook the search system. The search system acts as the backbone, fetching relevant information upon which the QA system builds its answers. 

#### Evaluating the Search System

For instances where the dataset might be limited, turning to synthetic data is a practical approach. This method involves selecting random text chunks or documents and then prompting a language model to generate questions that these texts could answer. 

```python

def test():

    text_chunk = sample_text_chunk()

    questions = ask_ai(f"generate questions that could be ansered by {text_chunk.text}")

    for question in questions:

        search_results = search(question)



    return {

        "recall@5": (1 if text_chunk in search_results[:5] else 0),

        ...

    }



average_recall = sum(test() for _ in range(n)) / n

```

#### Evaluating the Answering System

This is a lot trickier. It's also good to build in feedback mechanisms in order to get better scores.

The purpose of synthetic data is to help you quickly get some metrics out. It will help you build out this evaluation pipeline in hopes that as you get more users and more real questions, you'll be able to understand where we're performing well and where we're performing poorly using the suite of tests that we have. Precision, recall, mean ranking scores, etc.




### Getting Started with OpenAI Evals

```Python
    def eval_sample(self, test_sample, rng: random.Random):
        """
        Called by the `eval_all_samples` method to evaluate a single sample.

        ARGS
        ====
        `test_sample`: a line from the JSONL test file
        `rng`: should be used for any randomness that is needed during evaluation

        This method does the following:
        1. Generate a prompt that contains the task statement, a few examples, and the test question.
        2. Generate a completion from the model.
        3. Check if the generated answer is correct.
        """
        stuffing = rng.sample(self.train_samples, self.train_samples_per_prompt)

        prompt = [
            {"role": "system", "content": "Solve the following math problems"},
        ]

        for i, sample in enumerate(stuffing + [test_sample]):
            if i < len(stuffing):
                prompt += [
                    {"role": "system", "content": sample["problem"], "name": "example_user"},
                    {"role": "system", "content": sample["answer"], "name": "example_assistant"},
                ]
            else:
                prompt += [{"role": "user", "content": sample["problem"]}]


        result = self.completion_fn(prompt=prompt, temperature=0.0, max_tokens=1)
        sampled = result.get_completions()[0]

        evals.record_and_check_match(prompt=prompt, sampled=sampled, expected=test_sample["answer"])
```

creating high quality evals is one of the most impactful things you can do. 

Model grading: A two stage process where the model first answers the question, then we ask a model to look at the response to check if it’s correct.

Consider an input that asks the model to write a funny joke. The model then generates a completion. We then create a new input to the model to answer the question: "Is this following joke funny? First reason step by step, then answer yes or no" that includes the completion." We finally consider the original completion correct if the new model completion ends with "yes".

For best results, it makes sense to use a different model to do grading from the one that did the completion

#### Building an evaluation 

an eval is a dataset and an eval class that is defined in a YAML file

One way to speed up the process of building eval datasets, is to use GPT-4 to generate synthetic data


```python

## Use GPT-4 to generate synthetic data
# Define the system prompt and user input (these should be filled as per the specific use case)
system_prompt = """You are a helpful assistant that can ask questions about a database table and write SQL queries to answer the question.
    A user will pass in a table schema and your job is to return a question answer pairing. The question should relevant to the schema of the table,
    and you can speculate on its contents. You will then have to generate a SQL query to answer the question. Below are some examples of what this should look like.

    Example 1
    ```````````
    User input: Table museum, columns = [*,Museum_ID,Name,Num_of_Staff,Open_Year]\nTable visit, columns = [*,Museum_ID,visitor_ID,Num_of_Ticket,Total_spent]\nTable visitor, columns = [*,ID,Name,Level_of_membership,Age]\nForeign_keys = [visit.visitor_ID = visitor.ID,visit.Museum_ID = museum.Museum_ID]\n
    Assistant Response:
    Q: How many visitors have visited the museum with the most staff?
    A: SELECT count ( * )  FROM VISIT AS T1 JOIN MUSEUM AS T2 ON T1.Museum_ID   =   T2.Museum_ID WHERE T2.Num_of_Staff   =   ( SELECT max ( Num_of_Staff )  FROM MUSEUM ) 
    ```````````

    Example 2
    ```````````
    User input: Table museum, columns = [*,Museum_ID,Name,Num_of_Staff,Open_Year]\nTable visit, columns = [*,Museum_ID,visitor_ID,Num_of_Ticket,Total_spent]\nTable visitor, columns = [*,ID,Name,Level_of_membership,Age]\nForeign_keys = [visit.visitor_ID = visitor.ID,visit.Museum_ID = museum.Museum_ID]\n
    Assistant Response:
    Q: What are the names who have a membership level higher than 4?
    A: SELECT Name   FROM VISITOR AS T1 WHERE T1.Level_of_membership   >   4 
    ```````````

    Example 3
    ```````````
    User input: Table museum, columns = [*,Museum_ID,Name,Num_of_Staff,Open_Year]\nTable visit, columns = [*,Museum_ID,visitor_ID,Num_of_Ticket,Total_spent]\nTable visitor, columns = [*,ID,Name,Level_of_membership,Age]\nForeign_keys = [visit.visitor_ID = visitor.ID,visit.Museum_ID = museum.Museum_ID]\n
    Assistant Response:
    Q: How many tickets of customer id 5?
    A: SELECT count ( * )  FROM VISIT AS T1 JOIN VISITOR AS T2 ON T1.visitor_ID   =   T2.ID WHERE T2.ID   =   5 
    ```````````
    """

user_input = "Table car_makers, columns = [*,Id,Maker,FullName,Country]\nTable car_names, columns = [*,MakeId,Model,Make]\nTable cars_data, columns = [*,Id,MPG,Cylinders,Edispl,Horsepower,Weight,Accelerate,Year]\nTable continents, columns = [*,ContId,Continent]\nTable countries, columns = [*,CountryId,CountryName,Continent]\nTable model_list, columns = [*,ModelId,Maker,Model]\nForeign_keys = [countries.Continent = continents.ContId,car_makers.Country = countries.CountryId,model_list.Maker = car_makers.Id,car_names.Model = model_list.Model,cars_data.Id = car_names.MakeId]"

messages = [{
        "role": "system",
        "content": system_prompt
    },
    {
        "role": "user",
        "content": user_input
    }
]

completion = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=messages,
    temperature=0.7,
    n=5
)

for choice in completion.choices:
    print(choice.message.content + "\n")

```

Few other answers have minor syntax differences that caused the answers to get flagged.
In situations like this, it would be worthwhile exploring whether we should continue iterating on the prompt to ensure certain stylistic choices, or if we should modify the evaluation suite to capture this variation.
This type of failure hints at the potential need for model-graded evals as a way to ensure accuracy in grading the results



### LLMs Evals: A General Framework for Custom Evaluations

#### Model-Graded Evaluations

 This can be tricky as what defines a “good” response can be highly subjective. Rule-based evals can be useful to ensure certain data or information is or is not in our output. 

```
def create_eval_chain(
    agent_response,
    llm=ChatOpenAI(model="gpt-3.5-turbo", temperature=0),
    output_parser=StrOutputParser()
):
    """
    Creates an evaluation chain to assess the appropriateness of the agent's response.

    Parameters:
        agent_response (str): The response generated by the agent.
        llm (ChatOpenAI, optional): Language model used for evaluation.
            Defaults to ChatOpenAI(model="gpt-3.5-turbo", temperature=0).
        output_parser (OutputParser, optional): Output parser for parsing agent's response.
            Defaults to StrOutputParser().

    Returns:
        ChatPromptTemplate: Evaluation chain for assessing the agent's response.
    """

    delimiter = "####"

    eval_system_prompt = f"""You are an assistant that evaluates whether or not an assistant is producing valid responses.
    The assistant should be producing output in the format of [CUSTOM EVALUATION DEPENDING ON USE CASE]."""

    eval_user_message = f"""You are evaluating [CUSTOM EVALUATION DEPENDING ON USE CASE].
    Here is the data:
      [BEGIN DATA]
      ************
      [Response]: {agent_response}
      ************
      [END DATA]

    Read the response carefully and determine if it [MEETS REQUIREMENT FOR USE CASE]. Do not evaluate if the information is correct only evaluate if the data is in the expected format.

    Output 'True' if the response is appropriate, output 'False' if the response is not appropriate.
    """
    eval_prompt = ChatPromptTemplate.from_messages([
        ("system", eval_system_prompt),
        ("human", eval_user_message),
    ])

    return eval_prompt | llm | output_parser
```

Opt for the most robust model you can afford: Advanced reasoning capabilities are often required to effectively critique outputs. Your deployed system might need to have low latency for user experience. However, a slower and more powerful LLM might be needed for evaluating outputs effectively.
You could create a problem within a problem: Without careful consideration and design of your model-based evals. The evaluating model might make errors and give you a false sense of confidence in your system.
Create positive and negative evals: Something cannot be logically true and untrue at the same time. Carefully design your evals to increase confidence.



### Your AI Product Needs Evals

*  unsuccessful products almost always share a common root cause: a failure to create robust evaluation systems.
* You must have processes and tools for:

Evaluating quality (ex: tests).
Debugging issues (ex: logging & inspecting data).
Changing the behavior or the system (prompt eng, fine-tuning, writing code)

Many people focus exclusively on #3 above, which prevents them from improving their LLM products beyond a demo.


#### Case Study: Lucy, A Real Estate AI Assistant

During Lucy’s beginning stages, rapid progress was made with prompt engineering. However, as Lucy’s surface area expanded, the performance of the AI plateaued. Symptoms of this were:

Addressing one failure mode led to the emergence of others, resembling a game of whack-a-mole.
There was limited visibility into the AI system’s effectiveness across tasks beyond vibe checks.
Prompts expanded into long and unwieldy forms, attempting to cover numerous edge cases and examples.

You should spend most of your time making your evaluation more robust and streamlined.

There are three levels of evaluation to consider:

Level 1: Unit Tests
Level 2: Model & Human Eval (this includes debugging)
Level 3: A/B testing
The cost of Level 3 > Level 2 > Level 1. This dictates the cadence and manner you execute them. For example, I often run Level 1 evals on every code change, Level 2 on a set cadence and Level 3 only after significant product changes. It’s also helpful to conquer a good portion of your Level 1 tests before you move into model-based tests, as they require more work and time to execute.

#### Level 1: Unit Tests

Unlike typical unit tests, you want to organize these assertions for use in places beyond unit tests, such as data cleaning and automatic retries (using the assertion error to course-correct) during model inference. 

If you have trouble thinking of assertions, you should critically examine your traces and failure modes. Also, do not shy away from using an LLM to help you brainstorm assertions!

The most effective way to think about unit tests is to break down the scope of your LLM into features and scenarios. 

I often utilize an LLM to generate these inputs synthetically; for example, here is one such prompt Rechat uses to generate synthetic inputs for a feature that creates and retrieves contacts:

```
Write 50 different instructions that a real estate agent can give to his assistant to create contacts on his CRM. The contact details can include name, phone, email, partner name, birthday, tags, company, address and job.

For each of the instructions, you need to generate a second instruction which can be used to look up the created contact.

. The results should be a JSON code block with only one string as the instruction like the following:


[
  ["Create a contact for John (johndoe@apple.com)", 
  "What's the email address of John Smith?"]
]
```

For each of these test cases, we execute the first user input to create the contact. We then execute the second query to fetch that contact. If the CRM doesn’t return exactly 1 result then we know there was a problem either creating or fetching the contact. We can also run generic assertions like the one to verify UUIDs are not in the response.

One signal you are writing good tests and assertions is when the model struggles to pass them - these failure modes become problems you can solve with techniques like fine-tuning later on.

#### Level 2: Human & Model Eval

A prerequisite to performing human and model-based eval is to log your traces.Rechat was using LangChain which automatically logs trace events to LangSmith for you. 

I’ve often found that it’s better to build my own data viewing & labeling tool so I can gather all the information I need onto one screen.

What tool (feature) & scenario was being evaluated.
Whether the trace resulted from a synthetic input or a real user input.
Filters to navigate between different tools and scenario combinations.
Links to the CRM and trace logging system for the current record.

we noticed that many failures involved small mistakes in the final output of the LLM (format, content, etc). We decided to make the final output editable by a human so that we could curate & fix data for fine-tuning.

 When starting, you should examine as much data as possible. I usually read traces generated from ALL test cases and user-generated traces at a minimum. You can never stop looking at data—no free lunch exists. However, you can sample your data more over time, lessening the burden.

I often find that “correctness” is somewhat subjective, and you must align the model with a human.

Use the most powerful model you can afford. It often takes advanced reasoning capabilities to critique something well. You can often get away with a slower, more powerful model for critiquing outputs relative to what you use in production.
Model-based evaluation is a meta-problem within your larger problem. You must maintain a mini-evaluation system to track its quality. I have sometimes fine-tuned a model at this stage (but I try not to).
After bringing the model-based evaluator in line with the human, you must continue doing periodic exercises to monitor the model and human agreement.
My favorite aspect about creating a good evaluator model is that its critiques can be used to curate high-quality synthetic data, 

Evaluation systems create a flywheel that allows you to iterate very quickly. It’s almost always where people get stuck when building AI products. 








### All about LLM Evals

lack of easily pluggable evaluations for both the model and application-level LLM systems. Specifically, there’s often confusion regarding the vast array of LLM evaluation benchmarks, and when to utilize machine feedback, human feedback, or a combination of both.

#### What makes a good eval?

Covers the most important outcomes of your LLM-application
A small number of metrics, which are interpretable, preferably
Fast and automatic to compute
Tested on a diverse & representative dataset
Highly correlated with human judgment

 a translation could score high on BLEU for having words in technically correct order, but still miss the mark in conveying the right tone, style, or even meaning as intended in the original text.


#### LLM-assisted evals.

 the tools we develop to understand human language are also becoming the benchmark for evaluating themselves

Researchers are now employing LLMs like GPT-4 to evaluate the outputs of similar models. This recursive use of LLMs for evaluation underscores the continuous cycle of improvement and refinement in the field.

Human and GPT-4 judges can reach above 80% agreement on the correctness and readability score. If the requirement is smaller or equal to 1 score difference, the agreement level can reach above 95% 

Application-Specific: One major constraint is that LLM-driven evaluators produce application-specific metrics. A numeric score given by an LLM in one context does not necessarily equate to the same value in another, hindering the standardization of metrics across diverse projects.
Position Bias: According to a study, LLM evaluators often show a position bias, favoring the first result when comparing two outcomes. This can skew evaluations in favor of responses that appear earlier, regardless of their actual quality.
Verbose Bias: LLMs also tend to prefer longer responses. This verbosity bias means that more extended, potentially less clear answers may be favored over concise and direct ones.
Self-Affinity Bias: LLMs may exhibit a preference for answers generated by other LLMs over human-authored text, potentially leading to a skewed evaluation favoring machine-generated content.
Stochastic Nature: The inherent fuzziness within LLMs means they might assign different scores to the same output when invoked separately, adding an element of unpredictability to the evaluation.


Mitigations

Position Swapping: To counteract position bias, swapping the reference and the result in evaluations ensures the outcome being assessed is in the first position.
Few-shot Prompting: Introducing a few examples or prompts into the evaluation task can calibrate the evaluator and reduce biases like verbosity bias.
Hybrid Evaluation: To achieve a more grounded evaluation, integrating LLM-based assessments with human judgment or advanced non-traditional metrics can be highly effective. This combined approach offers a comprehensive assessment framework that balances the innovative capabilities of LLMs with the proven accuracy of non-traditional metrics.


#### Evaluation Methodology

The evaluation begins with the creation of a benchmark dataset, which should be as representative as possible of the data the LLM will encounter in a live environment.

Once we have our evaluation test set complete with ground truth and responses generated by our LLM application, the next step is to grade these results. This phase involves using a mix of LLM-assisted evaluation prompts and more integrated, hybrid approaches.


