# frozen_string_literal: true

module PaginationConcern
  extend ActiveSupport::Concern

  included do
    before_action :pagination_params, only: :index

    private

    def pagination_params
      filter_params.with_defaults(page: 1, limit: 25)
    end

    def with_pagination_options(records, request = nil, &block)
      total_records = records.total_count
      current_page = pagination_params[:page].to_i
      previous_page = current_page.eql?(1) ? 1 : current_page - 1
      total_pages = total_records.fdiv(pagination_params[:limit].to_i).ceil
      next_page = current_page.eql?(total_pages) || current_page > total_pages ? total_pages : current_page + 1
      options = {}
      options[:meta] = { count: records.size, total: total_records, previous_page: previous_page,
                         next_page: next_page, total_pages: total_pages }.merge(request: request)

      block.call(options) if block_given?
    end
  end
end
