namespace :diagrams do
  DOTS = FileList[File.join(File.dirname(__FILE__), 'files', 'diagrams', 'dot', "*.dot")]

  desc "Compile diagrams"
  task :compile do
    puts `./misc/compile_diagrams.sh`
  end

  desc "Generate diagrams"
  task :generate do
    if File.directory?('core')
      destination = File.join(File.dirname(__FILE__), 'files', 'diagrams', 'dot')
      # Generate all models
      calculators = Dir.glob('core/app/models/calculator/*.rb').map{|c| c.gsub('core/', '')}.join(",")
      `ruby misc/railroad -r core -M -i -l -e #{calculators}| sed 's/font-size:14.00/font-size:11.00/g' > #{destination}/models.dot`
      # adjustments and charges
      {
          'coupons' => ['coupon', 'coupon_credit', 'credit', 'calculator'],
          'taxation' => ["tax_rate", "tax_category", "zone", "state", "country", "tax_charge"],
          'products_grouping' => ["product", "variant", "taxon", "product_group", "taxonomy", "product_scope"],
          'shipping' => [
              "shipping_rate", "shipping_category", "shipping_method",
              "shipping_charge", "shipment", 'zone', 'country', 'state'
          ],
          'product_options' => [
              "product", "variant", "prototype", 'product_property', 'property',
              'product_option_type', 'option_type', 'option_value'
          ],
          'adjustments' => [
              'adjustment', 'charge', 'credit', 'coupon_credit', 'tax_charge',
              'shipping_charge', 'coupon', 'shipment', 'calculator', 'shipping_method'
          ]
      }.each_pair do |name, model_names|
        models = model_names.map{|mn| "app/models/#{mn}.rb"}.join(",")
        puts "creating .dot for #{name}"
        `ruby misc/railroad -l -M -i  -r core -I #{models} > #{destination}/#{name}.dot`
      end
      Rake::Task['diagrams:compile'].invoke
    else
      puts "To generate diagrams you have to sym link a spree core under 'core' in maind directory of documentation"
    end
  end
end

desc 'Generate guides (for authors), use ONLY=foo to process just "foo.textile"'
task :guides => 'diagrams:compile' do
  ruby "spree_guides.rb"
end

task :default => :guides
