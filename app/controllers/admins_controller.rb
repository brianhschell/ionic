class AdminsController < ApplicationController


  def projects
    if params[:project_name].present? 
      np = Project.new
      np.name = params[:project_name]
      np.start_date = params[:start_date]
      np.end_date = params[:end_date]
      np.save
    end
    @projects = Project.all
  end

  def sub_details
    @project = Project.find_by_id(params[:project_id])
    if params[:sub_type_id].present?
      ns= Sub.find_or_create_by(:project_id=>@project.id, :sub_type_id=>params[:sub_type_id][:id])
      ns.save
    end
    if params[:add_image].present?
      if params[:file].present?
        image = ::Image.new
        image.file = params[:file]
        image.image_type = 'custom_text'
        image.project_id = @project.id
        image.save
      end
    end
  end

  def sub_breakdown
    @sub = Sub.find_by_id(params[:s])
    @project = @sub.project
  end

  def estimates 
    @sub = Sub.find_by_id(params[:s])
    @project = @sub.project
  end


  def entry
    @sub = Sub.find_by_id(params[:s])
    @project = @sub.project
    @new_entry = SubDetail.new
    if params[:add_entry].present?
      @new_entry.event_type = params[:event_type]
      @new_entry.sub_id = @sub.id 
      @new_entry.notes = params[:notes]
      @new_entry.amount = params[:amount]
      @new_entry.event_date= params[:event_date]
      @new_entry.invoice= params[:invoice] || 0
      @new_entry.save
      if params[:file].present?
        image = ::Image.new
        image.file = params[:file]
        image.image_type = 'custom_text'
        image.sub_detail_id = @new_entry.id
        image.save
      end
      redirect_to sub_breakdown_admin_path(:s=>@sub.id)
    end
  end

  def new_estimate
    @sub = Sub.find_by_id(params[:s])
    @project = @sub.project
    @new_entry = Estimate.new
    if params[:add_entry].present?
      @new_entry.event_type = params[:event_type]
      @new_entry.sub_id = @sub.id 
      @new_entry.notes = params[:notes]
      @new_entry.amount = params[:amount]
      @new_entry.event_date= params[:event_date]
      @new_entry.save
      if params[:file].present?
        image = ::Image.new
        image.file = params[:file]
        image.image_type = 'custom_text'
        image.estimate_id = @new_entry.id
        image.save
      end
      redirect_to estimates_admin_path(:s=>@sub.id)
    end
  end


  def add_sub_type
    s = SubType.new(:name=>params[:name])
    s.save
    respond_to do |format|
      format.js { render :json => true, :status=> :ok }
    end
  end

  def iview
    if params[:sd].present?
      @detail = SubDetail.find_by_id(params[:sd])
      @sub_detail = true
    else
      @detail = Estimate.find_by_id(params[:e])
      @sub_detail = false 
    end
    if params[:project].present?
      @is_project = true
      @project = Project.find_by_id(params[:project])
    else
      @sub = Sub.find_by_id(params[:s])
      @project = @sub.project
      @is_project = false
    end 
    @url=params[:u]
  end

end
