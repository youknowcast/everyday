defmodule EverydayAppWeb.DayView do
  use EverydayAppWeb, :view

  def day_to_s(day) do
    Date.to_string(day)
  end
end
