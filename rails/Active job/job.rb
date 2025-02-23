Active Job runs in background and runs outside the main Thread
it basically used to download a large a file parallely in a separate Thread

A job is a ruby object that responds to perform method . perform method that needs to 
be executed in background

Queue:-  are stored are in a queue until they are processed. Dj uses a db table to manage Queue

workers:- background processed (workers) 
are responsible for fecthing the jobs and executing

rake jobs:work RAILS_ENV=production to run workers

advantage of DJ over sidekiq, reSeque

1. No Extra InfraStructure(uses existing DB)
2. Easy integration with Active Record
3. Simplicity (Minimal Configuration Needed)
4. Built in job Scheduling
5. Lower Memory Usage(application with limited resources)
6. Less maintaince


