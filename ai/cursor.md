Use @migrations/xxx.sql for AI to generate model code

@git generate UT based on the diff

Notepad can be passed to agent as context

Analyze which functions under {dictory} is too big and hard to maintain?
Generate the list into {dictory}/.todofunc, the file should be in a similar format as cursorrules


### Staged code gen

Create a backend servcie. This service has multiple API endpoints, defined in api_desc.md. The data structure is defined in schema.md
After you finish generating the code, generate api_doc.md, and update it whenenver theres is changes

Change the mock data to use the real API. The API spec is defined in api_doc.md


* Decide project knowledge points
* choose suitable template 
* let Cursor Agent extract knowledge 
* review the content
* Add to project-knowledge.md
* Add to cursor_docs/knowledge
* Breakdown the files if it is too big, use multiple @ to quote

@project-knowledge.md write me an example to use the member point service.

## Utility: 
** Purpose
** main methods
* Method signature -> **example** 
* List the most common, easily confusing 2-3 methods
**! Caution: **

## Service: 
** main purpose 
** main APIs
* API signature -> **usage: **create a new order
* List only the 1-2 core APIs

## Config:
** key options **
* `my.kafka.bootstrap-servers`: -> **example:**
* List only the most common, mutable, most prone to error ones

Generate the markdown in the agent mode.
Prompt: Read the open, analyze its main methods, and output with the following Markdown templates
Prompt: in the project search for all Util or Utils files, list their path
* for each tool type, extract the data
* core purpose
* Most common 2-3 public methods and signature
* Every method’s example
* Important things to watch out for

Organize result into the Markdown format. Save the result to docs/knowledge. 
