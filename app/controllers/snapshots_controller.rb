class SnapshotsController < ApplicationController

  def show
    Snapshot.new(params: params)
  end

end