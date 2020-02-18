class SongsController < ApplicationController
  def index
    # calls the helper to display the artist
    if params[:artist_id]
      # if artist_id exists 
      if Artist.find_by(id: params[:artist_id])
        @songs = Artist.find(params[:artist_id]).songs
      else # if artist not found
        # index redirects when artist not found
        flash[:alert] = "Artist not found."
        redirect_to artists_path
      end
    else
      # returns 200 when just index with no artist_id
      @songs = Song.all
    end
  end

  def show
    if Song.find_by(id: params[:id])
      # returns 200 with valid artist song
      # returns 200 with valid song and no artist
      @song = Song.find(params[:id])
    else
      # redirects to artists songs when artist song not found
      flash[:alert] = "Song not found."
      redirect_to artist_songs_path(params[:artist_id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

