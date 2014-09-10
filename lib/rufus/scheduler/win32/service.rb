require 'rufus/scheduler/win32/service/version'
require 'logger'
require 'win32/daemon'
require 'rufus-scheduler'

module Rufus
  module Scheduler
    # Containing module for the Service class
    module Win32
      include ::Win32

      # Service wrapper around rufus-scheduler
      class Service
        attr_writer :logger

        def service_main
          logger.info 'Running Main Loop'
          while scheduler.up?
            logger.debug 'Still Running'
            sleep 10
          end
          logger.info 'Scheduler down. Exiting main loop'
        end

        def service_stop
          logger.info 'Stopping scheduler service'

          scheduler.shutdown(:wait)

          logger.info 'Service stopped'
        end

        def service_pause
          logger.info 'Pausing scheduler service'

          scheduler.pause unless scheduler.paused?

          logger.info 'Paused scheduler service'
        end

        def service_resume
          logger.info 'Resuming scheduler service'

          scheduler.resume if scheduler.paused?

          logger.info 'Resumed scheduler service'
        end

        def scheduler
          @scheduler ||= Rufus::Scheduler.new
        end

        def logger
          @logger ||= Logger.new(STDOUT)
        end
      end
    end
  end
end
