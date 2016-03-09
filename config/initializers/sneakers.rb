require 'sneakers'
Sneakers.configure workers: 10, threads: 10, log: Rails.root.join('log/sneakers.log')
Sneakers.logger.level = Logger::INFO
