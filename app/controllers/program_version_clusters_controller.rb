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
    @program_version_cluster = ProgramVersionCluster.new program_version_cluster_params
    if @program_version_cluster.save
      redirect_to @program_version_cluster
    else
      render 'new'
    end
  end

  def update
    @program_version_cluster = ProgramVersionCluster.find(params[:id])
    if @program_version_cluster.update program_version_cluster_params
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

  def program_version_cluster_params
    ret_params = {}
    unless params[:program_version_cluster].nil? || params[:program_version_cluster][:programs_attributes].nil?
      programs_attributes = params[:program_version_cluster][:programs_attributes]
      pids = programs_attributes.to_unsafe_h.collect {|pa| pa[1][:id]}.uniq
      params[:program_version_cluster][:program_ids] = pids
      params[:program_version_cluster][:programs_attributes] = nil
      ret_params = params.require(:program_version_cluster).permit(:id, program_ids:[])
    end
    ret_params
  end

end
