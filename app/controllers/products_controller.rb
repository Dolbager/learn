class ProductsController < ApplicationController

	before_action :authenticate_user!, :except => [:show, :index]

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			flash[:notice] = "Product #{@product.name} successfully created"
			redirect_to :action => 'show' , :id => @product.id
		else
			render 'new'
		end
	end

	def show
		@product = Product.find(params[:id])
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])

		if @product.update(product_params)
			redirect_to products_path
		else
			render 'edit'
		end
	end
	
	def destroy
		@product = Product.find(params[:id])
		@product.destroy

		redirect_to products_path
	end

	def upload
  		uploaded_io = params[:product][:picture]
  		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    		file.write(uploaded_io.read)
  		end
	end

	private
	def product_params
		params.require(:product).permit(:name, :description, :image)
	end
end
