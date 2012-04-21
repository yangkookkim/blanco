Blanco::Application.routes.draw do

  # To handle salesforce callback url
  match '/auth/:provider/callback', :to => 'sessions#sfdc_client_auth'
  match '/instant_search' => 'application#instant_search'

  get 'employees/login'
  resources :employees do
    resources :profiles do
      resources :chatterfeeds do
        collection do
          get 'show_js'
          get 'post_feed_comment'
          get 'update_status'
          get 'delete_comment'
          get 'delete_feed'
        end
      end
      resources :chatterprofiles do
        collection do
          get 'show_js'
          get 'post_feed_comment'
          get 'update_status'
          get 'delete_comment'
          get 'delete_feed'
        end
      end
    end
    resources :groups do
      collection do
         get 'search_employees'
         get 'instant_search'
         get 'show_js'
         get 'instant_search_show_result'
         get 'monitor_posts_js'
      end   
      resources :posts do
        collection do
          get 'upload_image'
        end
      end
      resources :chatterfeeds do
         collection do
          get 'show_js'
          get 'post_feed_comment'
          get 'update_status'
          get 'delete_comment'
          get 'delete_feed'
        end
      end
      resources :chattergroups do
         collection do
          get 'show_js'
          get 'post_feed_comment'
          get 'update_status'
          get 'delete_comment'
          get 'delete_feed'
        end
      end
    end
    resources :restaurants do
      collection do
        get 'index_js'
        get 'search_restaurant'
	get 'get_restaurant_review_html'
	get 'index_get_active_message'
      end
      resources :posts do
        collection do
        end
      end
    end
  end
  
  resources :groups do
  end

  resources :posts do
  end

  resource :sessions do
    get 'sfdc_client_auth'
  end


end
