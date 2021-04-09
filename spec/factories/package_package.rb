FactoryBot.define do
  factory :package_package, class: PackagePackage do
    wrapper_package_id { 1 }
    contained_package_id { 1 }
  end
end
