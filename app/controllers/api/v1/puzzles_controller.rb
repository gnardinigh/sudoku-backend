class Api::V1::PuzzlesController < ApplicationController
    before_action :find_puzzle, only: [:update]
    def index
      @puzzles = Puzzle.all
      render json: @puzzles
    end

    def show
      @puzzle = Puzzle.find(params[:id])
      render json: @puzzle
    end

    def update
      @puzzle.update(puzzle_params)
      if @puzzle.save
        render json: @puzzle, status: :accepted
      else
        render json: { errors: @puzzle.errors.full_messages }, status: :unprocessible_entity
      end
    end

    private

    def puzzle_params
      params.permit(:title, :content)
    end

    def find_puzzle
      @puzzle = Puzzle.find(params[:id])
    end
  end
