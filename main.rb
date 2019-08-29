require './company';
require './region';
require './organization';

# Company hierarchy:
# {
#   "Company #1": {
#     "Region #1": {
#       "Region #2": [
#         "Organization #1",
#         "Organization #2"
#       ],
#       "Region #3": [
#         "Organization #3",
#         "Organization #4"
#       ]
#     },
#     "Region #4": {
#       "Region #5": {
#         "Region #6": [
#           "Organization #5",
#           "Organization #6"
#         ],
#         "Region #7": [
#           "Organization #7",
#           "Organization #8"
#         ]
#       },
#       "Region #8": {
#         "Region #10": [
#           "Organization #11",
#           "Organization #12"
#         ],
#         "Region #9": [
#           "Organization #9",
#           "Organization #10"
#         ]
#       }
#     }
#   }
# }
def setup
  @company = Company.new

  @region1 = Region.new
  @company.add_region(@region1)
  @region1.rebuild_path

  @region2 = Region.new
  @region1.add_child(@region2)
  @region2.rebuild_path

  @organization1 = Organization.new
  @region2.add_child(@organization1)
  @organization1.rebuild_path

  @organization2 = Organization.new
  @region2.add_child(@organization2)
  @organization2.rebuild_path

  @region2.rebuild_hierarchy



  @region3 = Region.new
  @region1.add_child(@region3)
  @region3.rebuild_path

  @organization3 = Organization.new
  @region3.add_child(@organization3)
  @organization3.rebuild_path

  @organization4 = Organization.new
  @region3.add_child(@organization4)
  @organization4.rebuild_path

  @region3.rebuild_hierarchy

  @region1.rebuild_hierarchy



  @region4 = Region.new
  @company.add_region(@region4)
  @region4.rebuild_path

  @region5 = Region.new
  @region4.add_child(@region5)
  @region5.rebuild_path

  @region6 = Region.new
  @region5.add_child(@region6)
  @region6.rebuild_path

  @organization5 = Organization.new
  @region6.add_child(@organization5)
  @organization5.rebuild_path

  @organization6 = Organization.new
  @region6.add_child(@organization6)
  @organization6.rebuild_path

  @region6.rebuild_hierarchy


  @region7 = Region.new
  @region5.add_child(@region7)
  @region7.rebuild_path

  @organization7 = Organization.new
  @region7.add_child(@organization7)
  @organization7.rebuild_path

  @organization8 = Organization.new
  @region7.add_child(@organization8)
  @organization8.rebuild_path

  @region7.rebuild_hierarchy

  @region5.rebuild_hierarchy


  @region8 = Region.new
  @region4.add_child(@region8)
  @region8.rebuild_path

  @region9 = Region.new
  @region8.add_child(@region9)
  @region9.rebuild_path

  @organization9 = Organization.new
  @region9.add_child(@organization9)
  @organization9.rebuild_path

  @organization10 = Organization.new
  @region9.add_child(@organization10)
  @organization10.rebuild_path

  @region9.rebuild_hierarchy


  @region10 = Region.new
  @region8.add_child(@region10)
  @region10.rebuild_path

  @organization11 = Organization.new
  @region10.add_child(@organization11)
  @organization11.rebuild_path

  @organization12 = Organization.new
  @region10.add_child(@organization12)
  @organization12.rebuild_path

  @region10.rebuild_hierarchy

  @region8.rebuild_hierarchy

  @region4.rebuild_hierarchy

  @company.rebuild_hierarchy

  puts 'Company hierarchy:'
  pp @company.hierarchy
  puts
end

def organizations_by_ids(organization_ids)
  organization_ids.map { |id| instance_variable_get("@organization#{id}") }
end

def paths_by_organization_ids(*organization_ids)
  grouped_organizations = organizations_by_ids(organization_ids).group_by(&:region)
  grouped_organizations.reduce([]) do |paths, (region, region_organizations)|
    if region.size == region_organizations.size
      paths << region.path
    else
      paths.concat(region_organizations.map(&:path))
    end
  end
end

# Paths for organizations #1, #3, #5, #6, #11:
# [
#   ['Region #1', 'Region #2', 'Organization #1'],
#   ['Region #1', 'Region #3', 'Organization #3'],
#   ['Region #4', 'Region #5', 'Region #6'],
#   ['Region #4', 'Region #8', 'Region #10', 'Organization #11']
# ]
def sample
  setup unless @company

  puts 'Command: `get_paths(1,3,5,6,11)`'
  pp get_paths(1, 3, 5, 6, 11)
  puts 'Now try for yourself!'
  puts
end

def get_paths(*organization_ids)
  organization_ids_str = organization_ids.map { |id| "##{id}" }.join(', ')
  puts "Paths for organizations #{organization_ids_str}:"
  pp paths_by_organization_ids(*organization_ids)
  puts
end
