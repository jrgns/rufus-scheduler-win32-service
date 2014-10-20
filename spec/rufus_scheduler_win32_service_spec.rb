require 'rufus/scheduler/win32/daemon'

describe RufusSchedulerWin32::Daemon do
  subject { RufusSchedulerWin32::Daemon.new }

  it 'provides a scheduler' do
    expect(subject).to respond_to :scheduler
  end

  it 'shuts down the scheduler when the service stops' do
    scheduler = double.as_null_object
    subject.stub(:scheduler) { scheduler }

    subject.service_stop

    expect(scheduler).to have_received(:shutdown).with(:wait)
  end

  it 'pauses the scheduler when the service pauses' do
    scheduler = double.as_null_object
    allow(scheduler).to receive('paused?').and_return(false)
    subject.stub(:scheduler) { scheduler }

    subject.service_pause

    expect(scheduler).to have_received(:pause)
  end

  it 'does not pause an already paused scheduler when the service pauses' do
    scheduler = double.as_null_object
    allow(scheduler).to receive('paused?').and_return(true)
    subject.stub(:scheduler) { scheduler }

    subject.service_pause

    expect(scheduler).to have_not_received(:pause)
  end

  it 'resumes the scheduler when the service resumes' do
    scheduler = double.as_null_object
    allow(scheduler).to receive('paused?').and_return(true)
    subject.stub(:scheduler) { scheduler }

    subject.service_resume

    expect(scheduler).to have_received(:resume)
  end

  it 'does not resume an already running scheduler when the service resumes' do
    scheduler = double.as_null_object
    allow(scheduler).to receive('paused?').and_return(false)
    subject.stub(:scheduler) { scheduler }

    subject.service_resume

    expect(scheduler).to have_not_received(:resume)
  end

  it 'has a basic logger' do
    expect(subject).to respond_to :logger
  end

  it 'can have another logger' do
    logger = Logger.new(STDOUT)
    subject.logger = logger
    expect(subject.logger).to be logger
  end
end
