class RelationshipsController < ApplicationController
	before_action :set_user

	def create
		user = User.find(params[:relationship][:follow_user_id])
		following = current_user.follow(user)
		if following.save
			flash[:success] = 'ユーザをフォローしました'
			redirect_to user
		else
			flash.now[:alert] = 'ユーザのフォローに失敗しました'
			redirect_to user
		end
	end

	def destroy
		user = User.find(params[:relationship][:follow_user_id])
		follwing = current_user.unfollow(user)
		if follwing.destroy
			flash[:success] = 'ユーザのフォローを解除しました'
			redirect_to user
		else
			flash.now[:alert] = 'ユーザのフォローの解除に失敗しました'
			redirect_to user
		end
	end

private

	def set_user
		user = User.find(params[:relationship][:follow_user_id])
	end

end

