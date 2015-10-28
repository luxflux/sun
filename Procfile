web: bundle exec puma -b unix://$BOXEN_SOCKET_DIR/sun -C ./config/puma.rb
state_processor: env WORKERS=StateProcessor bundle exec rake sneakers:run
statistics_processor: env WORKERS=StatisticsProcessor bundle exec rake sneakers:run
rules_dispatcher: env WORKERS=RulesDispatcher bundle exec rake sneakers:run
