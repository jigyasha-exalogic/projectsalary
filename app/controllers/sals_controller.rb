class SalsController < ApplicationController
	 before_action :admin?
  def new
		@sal=Sal.new
		@user = User.find(session[:user_id])
	end

	def create
		@error
    @sal = Sal.new(sal_params)
    @sal.id = session[:user_id]
    if @sal.save
      redirect_to user_path(session[:user_id])
    else
     	@error = "Please check the data"
      render 'new'
    end
	end

  def edit
    @sal = Sal.find(params[:id])
    @user = User.find(params[:id])
  end

   def update
      @sal = Sal.find(params[:id])
      if @sal.update(sal_params)
        redirect_to user_path(params[:id])
      else
        render 'edit'
      end
  end

	private

  def sal_params
    params.require(:sal).permit(:basic, :hra, :cca, :sa, :ta, :reim, :it, :pt, :lop, :od, :userid)
  end

   def admin?
    unless session[:user_type]=="admin"
      redirect_to root_path
    end
  end
end