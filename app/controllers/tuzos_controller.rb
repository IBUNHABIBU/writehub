class TuzosController < ApplicationController
  before_action :set_tuzo, only: %i[ show edit update destroy ]

  # GET /tuzos or /tuzos.json
  def index
    @tuzos = Tuzo.all
  end

  # GET /tuzos/1 or /tuzos/1.json
  def show
  end

  # GET /tuzos/new
  def new
    @tuzo = Tuzo.new
  end

  # GET /tuzos/1/edit
  def edit
  end

  # POST /tuzos or /tuzos.json
  def create
    @tuzo = Tuzo.new(tuzo_params)

    respond_to do |format|
      if @tuzo.save
        format.html { redirect_to @tuzo, notice: "Tuzo was successfully created." }
        format.json { render :show, status: :created, location: @tuzo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tuzo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tuzos/1 or /tuzos/1.json
  def update
    respond_to do |format|
      if @tuzo.update(tuzo_params)
        format.html { redirect_to @tuzo, notice: "Tuzo was successfully updated." }
        format.json { render :show, status: :ok, location: @tuzo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tuzo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tuzos/1 or /tuzos/1.json
  def destroy
    @tuzo.destroy!

    respond_to do |format|
      format.html { redirect_to tuzos_path, status: :see_other, notice: "Tuzo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tuzo
      @tuzo = Tuzo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tuzo_params
      params.expect(tuzo: [ :name, :email, :phone ])
    end
end
