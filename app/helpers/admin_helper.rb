module AdminHelper
  def toggle_activation_link(workshift)
    if workshift.aasm_events_for_current_state.include?(:activate)
      link_name = "Activate"
    elsif workshift.aasm_events_for_current_state.include?(:deactivate)
      link_name = "Deactivate"
    end

    link_to(
      link_name,
      toggle_activation_workshift_path( workshift ),
      :method => :put,
      :remote => true
    )
  end
end
