class CellsController < ApplicationController
  before_action :set_cell, only: %i[ show edit update destroy ]

  # GET /cells or /cells.json
  def index
    @cells = Cell.all
  end

  # GET /cells/1 or /cells/1.json
  def show
  end

  # GET /cells/new
  def new
    @cell = Cell.new
    @cell.notebook = Notebook.find(params[:notebook_id])
  end

  # GET /cells/1/edit
  def edit
  end

  # POST /cells or /cells.json
  def create
    @cell = Cell.new(cell_params)
    @cell.notebook = Notebook.find(params[:notebook_id])

    respond_to do |format|
      if @cell.save
        format.html { redirect_to notebook_url(@cell.notebook), notice: "Cell was successfully created." }
        format.json { render :show, status: :created, location: @cell }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cells/1 or /cells/1.json
  def update
    respond_to do |format|
      if @cell.update(cell_params)
        format.html { redirect_to cell_url(@cell), notice: "Cell was successfully updated." }
        format.json { render :show, status: :ok, location: @cell }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cell.errors, status: :unprocessable_entity }
      end
    end
  end

  def run_cell
    @cell = Cell.find(params[:id])
    code = @cell.content
    @cell.output = eval_with_captured_stdout{ eval(code) }

    respond_to do |format|
      if @cell.save!
        format.html { redirect_to notebook_url(@cell.notebook), notice: "Cell was successfully updated." }
        format.json { render :show, status: :ok, location: @cell }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cells/1 or /cells/1.json
  def destroy
    @cell.destroy!

    respond_to do |format|
      format.html { redirect_to cells_url, notice: "Cell was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cell
      @cell = Cell.find(cell_params)
    end
    
    def set_notebook
      @notebook = Notebook.find(params[:notebook_id])
    end

    # Only allow a list of trusted parameters through.
    def cell_params
      params.require(:cell).permit(:cell_type, :content, :output, :notebook_id)
    end

    def eval_with_captured_stdout
      original_stdout = $stdout
      $stdout = StringIO.new
      yield                      
      $stdout.string
    rescue Exception => e
      $stdout.puts e.message
      $stdout.puts e.backtrace
      $stdout.string
    ensure
      $stdout = original_stdout
    end

end
