#!/bin/bash
bundle exec sidekiq -d -L /var/www/prepaid/current/log/sidekiq.log -C /var/www/prepaid/current/config/sidekiq.yml -e production