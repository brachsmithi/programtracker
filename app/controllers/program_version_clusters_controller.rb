class ProgramVersionClustersController < ApplicationController

  def index
    @program_version_clusters = ProgramVersionCluster.all.paginate(page: @page, per_page: 15)
  end

  def show
    @program_version_cluster = ProgramVersionCluster.find params[:id]
  end

  def new
    @program_version_cluster = ProgramVersionCluster.new
  end

  def edit
    @program_version_cluster = ProgramVersionCluster.find params[:id]
  end

  def create
    @program_version_cluster = ProgramVersionCluster.new program_id_params
    if @program_version_cluster.save
      @program_version_cluster.update program_params
      redirect_to @program_version_cluster
    else
      render 'new'
    end
  end

  def update
    @program_version_cluster = ProgramVersionCluster.find(params[:id])
    if @program_version_cluster.update(program_id_params) && @program_version_cluster.update(program_params)
      redirect_to program_version_cluster_path(@program_version_cluster, page: @page)
    else
      render 'edit'
    end
  end

  def destroy
    pvc = ProgramVersionCluster.find params[:id]
    pvc.destroy
    redirect_to action: 'index'
  end

  private

  def program_params
    ret_params = {}
    local_params = params.dup
    unless local_params[:program_version_cluster].nil? || local_params[:program_version_cluster][:programs_attributes].nil?
      programs_attributes = params[:program_version_cluster][:programs_attributes]
      local_params[:program_version_cluster][:programs_attributes] = programs_attributes.to_unsafe_h.map {
        |epa| epa[1]
      }.select{
        |pa| !pa.nil? && !pa['name'].blank? 
      }
      ret_params = local_params.require(:program_version_cluster).permit(:id, programs_attributes:[:id, :name, :sort_name, :year])
    end
    ret_params
  end

  def program_id_params
    ret_params = {}
    local_params = params.dup
    unless local_params[:program_version_cluster].nil? || local_params[:program_version_cluster][:programs_attributes].nil?
      programs_attributes = local_params[:program_version_cluster][:programs_attributes]
      pids = programs_attributes.to_unsafe_h.collect {|pa| pa[1][:id]}.uniq
      local_params[:program_version_cluster][:program_ids] = pids
      ret_params = local_params.require(:program_version_cluster).permit(:id, program_ids:[])
    end
    ret_params
  end

end
