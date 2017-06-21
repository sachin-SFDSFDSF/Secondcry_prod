class FormsController < ApplicationController
	skip_before_filter :verify_authenticity_token


 def new
 end
 
 def create
 	Person.create(:name => params[:name])
 	render "new"
 end
end