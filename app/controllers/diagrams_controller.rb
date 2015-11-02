class DiagramsController < ApplicationController
  def index
  end


  def show
    @diagram = Diagram.find(params[:id]) 
  end

  def new
    @diagram = Diagram.new
  end

  def create
    @diagram = Diagram.new(diagram_params)
    if @diagram.save
      redirect_to @diagram, alert: "Processing data..."
    else
      redirect_to new_diagram_path, alert: "Error accepting data!"
    end
  end

   def compute_cashflow(investment, year)
     return investment+year 
   end

  private
  def diagram_params
    params.require(:diagram).permit(:investment, :MARR, :capacity, :pur, :puc, :om, :salv, :horiz, :deprec_time, :deprec_type, :DB_per, :loan_amt, :loan_time, :loan_interest_rate, :loan_type, :tax_rate)
  end

end
