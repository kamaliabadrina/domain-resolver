class ResolverController < ApplicationController
  def index
    @history = QueryHistory.all.order(created_at: :desc)  # Fetch recent queries

    if params[:domain].present?
      @domain = params[:domain]
      @query_type = params[:query_type] || 'A'  # Default to 'A' if no query type is provided
      @result = resolve_domain(@domain, @query_type)
      save_query_history(@domain, @query_type)  # Save this query to history
    end

    if params[:history_id].present?
      history = QueryHistory.find(params[:history_id])
      @domain = history.domain_name
      @query_type = history.query_type
      @result = resolve_domain(@domain, @query_type)  # Get the result for that query
    end
  end

  def destroy
    # Delete a single query history entry
    history = QueryHistory.find(params[:id])
    history.destroy
    redirect_to resolver_index_path, notice: "Query history deleted."
  end

  def clear_all
    # Delete all query history entries
    QueryHistory.delete_all
    redirect_to resolver_index_path, notice: "All query history deleted."
  end

  private

  def resolve_domain(domain, query_type)
    # Call the dig tool through the system to resolve the domain
    result = `dig #{domain} #{query_type}`
    result
  end

  def save_query_history(domain, query_type)
    # Save the query to the database for history
    QueryHistory.create(domain_name: domain, query_type: query_type)
  end
end
