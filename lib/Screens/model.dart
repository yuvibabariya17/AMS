import 'package:booking_app/Screens/modelitem.dart';

// List<hairservice> hairserviceItems = <hairservice>[
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '09:00 AM',
//       title: 'Hair Cut',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '09:30 AM',
//       title: 'Nail Treatments',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '10:00 AM',
//       title: 'Tanning',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '10:30 AM',
//       title: 'Bridal MakeUp',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '11:00 AM',
//       title: 'Skin Treatment',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '11:30 AM',
//       title: 'Massages',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '12:00 PM',
//       title: 'Hair Colouring',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '12:30 PM',
//       title: 'Hair Cut',
//       duration: "09:00 AM TO 09:30 AM"),
//   hairservice(
//       description:
//           "DescriptiondnfjghjhjhjgjbghjhfjuiojsocfijoizjcoSjfojxzovjoxvcj",
//       time: '01:00 PM',
//       title: 'Bridal MakeUp',
//       duration: "09:00 AM TO 09:30 AM"),
// ];

class ServiceSlot {
  final String time;
  final List<ServiceDetails> details;

  ServiceSlot({required this.time, required this.details});
}

class ServiceDetails {
  final String title;
  final String description;
  final String duration;

  ServiceDetails({
    required this.title,
    required this.description,
    required this.duration,
  });
}

 List<ServiceSlot> hairserviceItems = <ServiceSlot>[
    ServiceSlot(
      time: '09:00 AM',
      details: [
        ServiceDetails(
          title: 'Hair Cut',
          description: 'Description for Hair Cut',
          duration: '09:00 AM TO 09:30 AM',
        ),
        ServiceDetails(
          title: 'Hair Cut',
          description: 'Description for Hair Cut',
          duration: '09:00 AM TO 09:30 AM',
        ),
      ],
    ),
    ServiceSlot(
      time: '09:30 AM',
      details: [
        ServiceDetails(
          title: 'Nail Treatments',
          description: 'Description for Nail Treatments',
          duration: '09:00 AM TO 09:30 AM',
        ),
      ],
    ),
     ServiceSlot(
      time: '10:00 AM',
      details: [
        ServiceDetails(
          title: 'Nail Treatments',
          description: 'Description for Nail Treatments',
          duration: '09:00 AM TO 09:30 AM',
        ),
      ],
    ),
     ServiceSlot(
      time: '10:30 AM',
      details: [
        ServiceDetails(
          title: 'Nail Treatments',
          description: 'Description for Nail Treatments',
          duration: '09:00 AM TO 09:30 AM',
        ),
      ],
    ),
     ServiceSlot(
      time: '11:00 AM',
      details: [
        ServiceDetails(
          title: 'Nail Treatments',
          description: 'Description for Nail Treatments',
          duration: '09:00 AM TO 09:30 AM',
        ),
      ],
    ),
    // Add more entries as needed
  ];

