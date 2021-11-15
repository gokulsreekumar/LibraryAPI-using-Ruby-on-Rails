# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      # GET /books
      def index
        @books = Book.all
        render json: @books
      end

      # GET /books/:id
      def show
        if Book.exists?(params[:id])
          @book = Book.find(params[:id])
          render json: @book
        else
          render json: { message: 'Unable to get the Book.' }, status: 400
        end
      end

      # POST /books
      def create
        @book = Book.new(book_params)
        if @book.save
          render json: @book
        else
          render error: { error: 'Unable to create Book.' }, status: 400
        end
      end

      # PUT /books/:id
      def update
        @book = Book.find(params[:id])
        if @book
          @book.update(book_params)
          render json: { message: 'Book updated successfully.' }, status: 200
        else
          render json: { message: 'Unable to update Book.' }, status: 400
        end
      end

      # DELETE /books/:id
      def destroy
        @book = Book.find(params[:id])
        if @book
          @book.destroy
          render json: { message: 'Book deleted successfully.' }, status: 200
        else
          render json: { message: 'Unable to delete Book.' }, status: 400
        end
      end

      private

      def book_params
        params.require(:book).permit(:b_title, :author, :publisher, :year)
      end
    end
  end
end
