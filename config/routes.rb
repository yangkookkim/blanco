Blanco::Application.routes.draw do

  # To handl salesforce callback url
  match '/auth/:provider/callback', :to => 'sessions#sfdc_client_auth'
  match '/instant_search' => 'application#instant_search'

  get 'employees/login'
  resources :employees do
    resources :profiles do
      resources :chatterprofiles, :controller => 'chatterfeeds' do
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
      resources :chattergroups, :controller => 'chatterfeeds' do
         collection do
          get 'show_js'
          get 'post_feed_comment'
          get 'update_status'
          get 'delete_comment'
          get 'delete_feed'
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
