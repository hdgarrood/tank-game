require 'gtk2'

class WatchesWindow
  def initialize
    @tree_view = Gtk::TreeView.new
    setup_tree_view(@tree_view)
    @window = init_window
    @scrolled_window = init_scrolled_window
    @window.add(@scrolled_window)
    @window.show_all
    @window.move(670, 10)
  end

  def update
    @target = @target_block.call
    update_tree_view
    set_window_title
  end

  def watch(&block)
    @target_block = block
  end

  def show
    Thread.new { Gtk.main }
  end

  def destroyed?
    @window.destroyed?
  end

  private
  # enum for columns
  NAME, VALUE = 0, 1

  def update_tree_view
    store = Gtk::ListStore.new(String, String)
    @target.instance_variables.each do |ivar|
      row = store.append

      row[NAME] = ivar.to_s[1..-1]
      row[VALUE] = @target.instance_variable_get(ivar).to_s
    end
    @tree_view.model = store
  end

  def set_window_title
    @window.title = "Watching: #{@target}"
  end

  # Add two columns to the tree view
  def setup_tree_view(tree_view)
    # Create a new GtkCellRendererText, add it to the tree
    # view column and append the column to the tree view.
    renderer = Gtk::CellRendererText.new
    column   = Gtk::TreeViewColumn.new("Name", renderer, :text => NAME)
    tree_view.append_column(column)

    renderer = Gtk::CellRendererText.new
    column   = Gtk::TreeViewColumn.new("Value", renderer, :text => VALUE)
    tree_view.append_column(column)
  end

  # creates the Gtk::Window and returns it
  def init_window
    window = Gtk::Window.new("Watches")
    window.resizable = true
    window.border_width = 10
    window.signal_connect('destroy') { Gtk.main_quit }
    window.set_size_request(500, 300)
    window
  end

  def init_scrolled_window
    scrolled_window = Gtk::ScrolledWindow.new
    scrolled_window.add(@tree_view)
    scrolled_window.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
    scrolled_window
  end
end
