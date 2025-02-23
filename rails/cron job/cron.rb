cron job is command line tool that allows you schedule and run 
reoccuring tasks for specific period of time

# minute(0-59)
# hour(0-23)
# day (1-31)
#month (1-21)
# day of week(0-6) 

midnght of 1 january

0 0 1 1 *

1. 0 0 1 1 *
This cron expression means:

Minute: 0 (at the 0th minute)
Hour: 0 (at midnight)
Day of the month: 1 (on the 1st day of the month)
Month: 1 (in January)
Day of the week: * (any day of the week)
Job schedule: This job runs once a year at midnight on January 1st.



0 0 1 * *

This cron expression means:

Minute: 0 (at the 0th minute)
Hour: 0 (at midnight)
Day of the month: 1 (on the 1st day of the month)
Month: * (every month)
Day of the week: * (any day of the week)
Job schedule: This job runs once a month, at midnight on the 1st day of every month.

0 0 * *  0

This cron expression means:

Minute: 0 (at the 0th minute)
Hour: 0 (at midnight)
Day of the month: * (any day of the month)
Month: * (every month)
Day of the week: 0 (on Sunday)
Job schedule: This job runs once a week, at midnight on Sunday (since 0 represents Sunday).