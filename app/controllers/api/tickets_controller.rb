class Api::TicketsController < ApiController
  def index
    @tickets = Ticket.all

    render json: @tickets, status: :ok
  end

  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: ticket, status: 201, location: ticket
    end
  end

  def show
    @ticket = Ticket.find(params[:id])

    render json: @ticket, status: :ok
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
