module ApplicationHelper
  def full_title(page_title = "")
    # Helper отображает наименование вкладки в зависимости от того, на какой странице находимся
    base_title = "AskIt"
    # Если наименование страницы установлено, то что-то делаем
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def currently_at(current_page = '')
    # Helper определяет, на какой странице мы находимся. Важно, что рендерим :partial, иначе отобразит всю форму, а не yield
    # locals: - создание локальной переменной модуля, где в {} указываем, что надо передать и саму переменную
    render partial: 'shared/menu', locals: {current_page: current_page}
  end

  def nav_tab(title, url, options = {})
    # Используем собственный helper вместо link_to
    current_page = options.delete :current_page
    # Если текущая страница совпадает с той, на которой мы находимся, то выводим secondary иначе white
    css_class = current_page == title ? 'text-secondary' : 'text-white'
    # Теперь надо передать эти стили в class у кнопки
    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end
    link_to title, url, options
  end
end
