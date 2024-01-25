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
    // Add more entries as needed
  ];
