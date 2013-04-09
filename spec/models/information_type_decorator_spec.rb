require 'spec_helper'

describe "InformationTypeDecorator" do
  before {
    #create an information_type
    @itype_name = InformationType.new
    @itype_name.key = :name
    @itype_name.name = "Name"
    @itype_name.save

    @itype_phone = InformationType.new
    @itype_phone.key = :phone
    @itype_phone.name = "Telefon"
    @itype_phone.save

    #create an actor type
    @atype_doctor = ActorType.new
    @atype_doctor.name = "Arzt"
    @atype_doctor.key = :doctor
    @atype_doctor.save

    #create some information type decorators
    @itypedec_name = InformationTypeDecorator.create(@itype_name, @atype_doctor, true, true)
    @itypedec_phone = InformationTypeDecorator.create(@itype_phone, @atype_doctor, true, true)

  }

  it "creates an information type decorator" do
    @itypedec_name.should_not be_nil
    @itypedec_phone.should_not be_nil
    @itypedec_name.should be_an_instance_of(InformationTypeDecorator)
    @itypedec_phone.should be_an_instance_of(InformationTypeDecorator)
  end
  it "directs missing methods to its information type" do
    @itypedec_name.key.should be(@itype_name.key)
    @itypedec_phone.key.should be(@itype_phone.key)
    @itypedec_name.name.should be(@itype_name.name)
    @itypedec_phone.name.should be(@itype_phone.name)
  end

end