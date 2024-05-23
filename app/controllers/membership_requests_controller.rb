class MembershipRequestsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_group
  before_action :set_membership_request, only: [:update, :destroy]

  def create
    @group = Group.find(params[:group_id])
    @membership_request = @group.membership_requests.new(customer: current_customer)
    if @membership_request.save
      redirect_to @group, notice: "Membership request sent."
    else
      redirect_to @group, alert: "Failed to send membership request."
    end
  end

  def update
    if @membership_request.update(status: params[:status])
      redirect_to @group, notice: "Membership request #{params[:status]}."
    else
      redirect_to @group, alert: "Failed to update membership request."
    end
  end

  def destroy
    @membership_request.destroy
    redirect_to @group, notice: "Membership request cancelled."
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_membership_request
    @membership_request = @group.membership_requests.find(params[:id])
  end
end