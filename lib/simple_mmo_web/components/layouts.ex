defmodule SimpleMmoWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use SimpleMmoWeb, :controller` and
  `use SimpleMmoWeb, :live_view`.
  """
  use SimpleMmoWeb, :html

  embed_templates "layouts/*"
end
