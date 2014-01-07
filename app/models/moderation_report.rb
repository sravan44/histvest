class ModerationReport
	include Datagrid

	scope do
		Topic.includes(:user).where(:published => false).order("updated_at DESC")
	end
	
	filter(:title, :string) {|value| where("title ilike '#{value}%'")}
end