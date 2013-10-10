TaobaoQrcode::Application.routes.draw do
  resources :feedbacks

  resources :logos

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboard#index'
  get 'dashboard/faq' => 'dashboard#faq',as: :faq

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  #公共二维码服务
  concern :public_qr_code_service do
    collection do
      get :public_qr_code_service
    end
  end
  resources :items,concerns: :public_qr_code_service,:only => [:index,:show] do
    collection do
      get :download_zip
    end
    member do
      #下载商品条形码
      get :download_qr
      put :img_upload
      put :picture_upload
      get :qr_code_img
    end
  end

  resources :shops,concerns: :public_qr_code_service,:only => [:index,:show] do
    collection do
      #获取当前登录用户的店铺信息
      get :current
      get :current_download_qr
      get :current_qr_code_img
      put :current_qr_upload

      get :current_card
      put :generate_card

      get :current_card_download_qr
      get :current_card_qr_code_img
      put :current_card_qr_upload
    end
  end

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
