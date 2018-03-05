class AddPreviousRefreshTokenToAccessTokens < ActiveRecord::Migration[5.1][4.2]
  def change
    add_column(
      :oauth_access_tokens,
      :previous_refresh_token,
      :string,
      default: "",
      null: false
    )
  end
end
