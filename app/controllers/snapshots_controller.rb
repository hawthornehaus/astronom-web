class SnapshotsController < ApplicationController

  def show
    snapshot = Snapshot.new(params: params)

    respond_to do |format|
      format.json { render json: snapshot.as_json }
    end
  end

end