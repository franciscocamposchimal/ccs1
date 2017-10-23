100.times do
Client.create([
   status:'Activo',
   nombre: Faker::Name.first_name,
   apellidos: Faker::Name.last_name,
   tipo: 'Cliente',
   localidad: Faker::Address.city,
   direccion: Faker::Address.street_address,
   celular: Faker::PhoneNumber.phone_number,
   ine: 'dfghjkldghjklg',
   ruta:'2',
   grupo: '1',
   monto:'1500',
   visita:'2017-09-28',
       warranties_attributes: [
         id:,
         garantia1:'tv',
         garantia2:'tv',
         garantia3:'tv',
         garantia4:'tv'],
       avals_attributes: [
         id: Faker::Number.between(1, 100),
         nombre: Faker::Name.first_name:,
         apellidos: Faker::Name.last_name,
         ine: Faker::Number.between(1, 10),
         direccion: Faker::Address.street_address,
         celular: Faker::PhoneNumber.phone_number ]
       ])
end
