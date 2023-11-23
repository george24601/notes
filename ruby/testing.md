* Avoid touching the database during tests. FactoryGirl.build_stubbed will create a model instance that won’t be allowed to save to the database.
* Avoid calling external services. VCR is great for recording actual responses from external services and letting you replay them.
* Avoid touching the file system. Stub/mock the file system interactions (unless you are specifically testing a file system operation).
* Fixtures are best for integration tests and complex controllers
* Factories are best for unit tests and simple controllers
* Test doubles are best when you want to avoid slow network or external calls or you just want your tests to be isolated from other parts of the code so it's more of a unit test.
* build(:user): Returns an unsaved model. Rather use build_stubbed below
* create(:user): returns a saved model. only use if absolutely necessary, try to think if you can structure test without it
* attributes_for(:user): returns a hash of attributes, useful for controller tests params
* build_stubbed(:user): Returns an unsaved model with fake ID and save raises exception. Best for most situations, fake ID helps with associations

* Don't specify associations in factory definitions, rather associate with a specific test
  * Prevents creation of large object trees
  * Prevents multiple degrees of associated objects being created
  * Will result in a bit more typing, but worth it for maintainability and speed

* Use Relative Dates: starts_at { 1.day.ago }
* Stubbing Time: Either use timecop or new Rails 4.1 time methods
  * If you use timecop, remember to call Timecop.return so that time behaves normally again, after your spec runs

```ruby

 factory :user do
 sequence(:email) { |n| "email_#{n}@example.com" }
 end
 factory :admin_user, parent: :user do
 role :admin
 end
 factory :shopper_user, parent: :user do
 role :shopper
 end
end
```

* DateTime and Date are not comparable
* Best practice is to convert to string format to compare:  some_date.to_s(:db)
* subject vs let

```ruby
context "when not found" do

  before do
    allow(Resource).to receive(:where).with(created_from: params[:id])
      .and_return(false)
  end

  it { is_expected.to respond_with 404 }
end
```
*  Do not use fixtures because they are difficult to control, use factories instead. Use them to reduce the verbosity on creating new data 
* Do not use should when describing your tests. Use the third person in the present tense

```ruby
it 'does not change timings' do
  expect(consumption.occur_at).to eq(valid.occur_at)
end
```

```ruby

context "with unauthorized access" do

  let(:uri) { 'http://api.lelylan.com/types' }
  before    { stub_request(:get, uri).to_return(status: 401, body: fixture('401.json')) }

  it "gets a not authorized notification" do
    page.driver.get uri
    expect(page).to have_content 'Access denied'
  end
end
```





