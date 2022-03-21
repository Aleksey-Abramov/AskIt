module ErrorHandling
  extend ActiveSupport::Concern

  included do
    # Обработка ошибок, в случае, когда id не найден
    # Указали, каким методом обрабатывается
    rescue_from ActiveRecord::RecordNotFound, with: :notfound

    private

    def notfound(exception)
      # Вызывается как обработчик исключения
      # Записали в лог
      logger.warn exception
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
