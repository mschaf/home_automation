class SchedulesController < ApplicationController

  def new
    build_schedule
  end

  def create
    build_schedule
    if save_schedule
      redirect_to @schedule.actor
    else
      render 'new'
    end
  end

  def edit
    load_schedule
    build_schedule
  end

  def update
    load_schedule
    build_schedule
    if save_schedule
      redirect_to @schedule.actor
    else
      render 'edit'
    end
  end

  def destroy
    load_schedule
    @schedule.destroy
    redirect_to @schedule.actor
  end

  private

  def load_schedules
    @schedules ||= schedule_scope.to_a
  end

  def load_schedule
    @schedule ||= schedule_scope.find(params[:id])
  end

  def build_schedule
    @schedule ||= schedule_scope.build
    @schedule.attributes = schedule_params
  end

  def save_schedule
    @schedule.save
  end

  def schedule_params
    schedule_params = params[:schedule]
    schedule_params ? schedule_params.permit(:action,
                                             :execute_at,
                                             :actor_id,
                                             :execute_on_monday,
                                             :execute_on_tuesday,
                                             :execute_on_wednesday,
                                             :execute_on_thursday,
                                             :execute_on_friday,
                                             :execute_on_saturday,
                                             :execute_on_sunday
                                            ) : {}
  end

  def schedule_scope
    Schedule.all
  end

end