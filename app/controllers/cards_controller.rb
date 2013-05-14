class CardsController < ApplicationController

  def owns?()
    c = Card.find params[:id]
    unless c.user_id == current_user.id
      redirect_to :cards
    end
  end

  before_filter :authenticate_user!, :except => ["index", "show"]
  before_filter :owns?, :only => ["edit", "update", "destroy"] 

  # GET /cards
  # GET /cards.json
  def index
    if params[:username]
      unless params[:username] == "all"
        user = User.where(:name => params[:username]).first
        @cards = Card.where :user_id => user.id
      else
        @cards = Card.all
      end
    else
      if current_user
        @cards = Card.where :user_id => current_user.id
      else
        @cards = Card.all
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    if params[:id]
      @card = Card.find(params[:id])
    else
      user = User.where(:name => params[:username]).first
      @card = Card.where(:name => params[:cardname], :user_id => user.id).first
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    card = params[:card]
    card[:user_id] = current_user.id
    @card = Card.new card

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end
end
