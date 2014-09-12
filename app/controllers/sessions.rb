	get '/sessions/new' do
		erb :"sessions/new"
	end

	post '/sessions' do
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
			redirect to('/')
	
		else
			flash[:errors] = ["The email or password is incorrect"]
			erb :"sessions/new"

		# else

		# 	flash[:notice] = ["a reset link has been emailed to you."]
			
		end
	end

	delete '/sessions' do
		session[:user_id] = nil
		flash[:notice] = ["Goodbye!"]
		redirect to('/')
	end

	post '/sessions/forgotten' do
		# email = params[:email]
		erb :"sessions/forgotten"
	end

	# post '/sessions/forgotten' do

	# end