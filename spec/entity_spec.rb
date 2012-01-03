require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'entity'

describe Entity do

  before :each do
    @file = "spec/entities/test_entity.yml"
    @attr = { :name => "Test Entity",
              :type => "Test",
              :description => "He's just a lil test entity",
              :height => 4.7,
              :weight => 80 }
  end

  describe "properties" do

    it "should remember properties/value pairs" do
      entity = Entity.new(@attr)
      entity.properties.should == @attr
    end

    describe "adding" do

      it "should be able to add a property without a value" do
        entity = Entity.new
        entity.add_property(:name)
        entity.properties.keys.should include(:name)
      end

      it "should be able to add a property/value pair" do
        entity = Entity.new
        entity.add_property(:name, "Example")
        entity.name.should == "Example"
      end

      it "should not change the value of a previously defined property if no value is given" do
        entity = Entity.new
        entity.add_property(:name, "Example")
        lambda do
          entity.add_property(:name)
        end.should_not change(entity, :name)
      end

      it "should change the value of a previously defined property if a value is given" do
        entity = Entity.new
        entity.add_property(:name, "Example")
        lambda do
          entity.add_property(:name, "New Name")
        end.should change(entity, :name).to("New Name")
      end

      it "should add a getter when a property is added" do
        entity = Entity.new
        entity.add_property(:name, "Example")
        entity.name.should == "Example"
      end

      it "should add a setter when a property is added" do
        entity = Entity.new
        entity.add_property(:name)
        entity.name = "Example"
        entity.name.should == "Example"
      end
    end

    describe "removing" do

      before :each do
        @entity = Entity.new(@attr)
      end

      it "should be able to remove a property" do
        @entity.remove_property(:name)
        @entity.properties.keys.should_not include(:name)
      end

      it "should remove the property's getter when removed" do
        @entity.remove_property(:name)
        @entity.should_not respond_to(:name)
      end

      it "should remove the property's setter when removed" do
        @entity.remove_property(:name)
        @entity.should_not respond_to(:name=)
      end
    end
  end

  describe "eql?" do

    it "should be equal to another entity if both have the save properties and values" do
      entity1 = Entity.new(@attr)
      entity2 = Entity.new(@attr)
      entity1.should be_eql(entity2)
    end

    it "should not be equal if the other entity has a different property or value" do
      entity1 = Entity.new(@attr)
      entity2 = Entity.new(@attr.merge(:name => "Different"))
      entity1.should_not be_eql(entity2)
    end

    it "should not be equal if the other object is not an entity" do
      entity = Entity.new
      obj = Object.new
      entity.should_not be_eql(obj)
    end

  end

  describe "creation" do

    it "should be able to create an empty entity" do
      entity = Entity.new
      entity.properties.should == {}
    end

    it "should be able to create an entity from a yml file" do
      Entity.load(@file).
        should be_an_instance_of(Entity)
    end

    it "should be able to create an entity from a hash" do
      Entity.new(@attr).should be_an_instance_of(Entity)
    end

    it "should be able to create the same entity from an equivalent file and hash" do
      hash_entity = Entity.new(@attr)
      file_entity = Entity.load(@file)
      hash_entity.should be_eql(file_entity)
    end
  end

end
