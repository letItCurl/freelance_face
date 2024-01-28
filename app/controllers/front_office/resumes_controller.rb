class FrontOffice::ResumesController < FrontOfficeController
  before_action :redirect_bots

  def show
    @resume = Resume.includes(:user).where(users: {username: params[:username]}, resumes: {id: params[:resume_id]})&.first
    raise AbstractController::ActionNotFound.new("not found") if @resume.nil?
    @user = @resume.user
    puts "☕️"
    puts "REMOTE IP#{request.remote_ip}"
    puts "UA #{request.user_agent}"
    puts "User Device LIST 🃏"
    puts @user.devices.inspect
    puts @user.devices.class
    puts "User Device 🃏"
    puts @user.devices.where(remote_ip: request.remote_ip, user_agent: request.user_agent).nil?
    puts "❤️❤️❤️❤️❤️"
    puts @user.devices.where(remote_ip: request.remote_ip, user_agent: request.user_agent)&.first&.nil?
    puts "❤️❤️❤️❤️❤️"
    puts @user.devices.where(remote_ip: request.remote_ip, user_agent: request.user_agent)&.first
    puts "❤️❤️❤️❤️❤️"
    if @user.devices.where(remote_ip: request.remote_ip, user_agent: request.user_agent)&.first&.nil?
      puts "IN LOOP"
      @resume.views.create(remote_ip: request.remote_ip, user_agent: request.user_agent)
    end
  end

  private

  def redirect_bots
    if CrawlerDetect.is_crawler?(request.user_agent)
      render status: :unauthorized and return
    end
  end
end
