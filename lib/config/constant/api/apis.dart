class AppConstants {
  static const defaultPadding = 16.0;

  // static const baseUrl = "http://44.205.137.19:4040";
  // static const ticketsUrl = "http://44.205.137.19:4040";
  // static const baseUrl = "http://13.203.82.90:4040";
  // static const ticketsUrl = "http://13.203.82.90:4040";
  static const baseUrl = "https://trukmitra.com/API";
  static const ticketsUrl = "https://trukmitra.com/API";
  // static const baseUrl = "http://3.7.171.161:4040/API";
  // static const ticketsUrl = "http://3.7.171.161:4040/API";
  // static const baseUrl = "http://3.7.171.161:4040";
  // static const ticketsUrl = "http://3.7.171.161:4040";
  static const aggregateUrl = "$baseUrl/part/categoryparts/";
  static const vehicleInvestigation =
      "$baseUrl/vehicleinvestigation/vehicle-investigations/";

  static const loginUrl = "$baseUrl/customer/login";
  static const loginMpinUrl = "$baseUrl/users/verify-mpin";
  static const forgotPassword = "$baseUrl/users/forgot-password";
  static const verifyOTP = "$baseUrl/users/verify-otp";
  static const changeForgotPassword = "$baseUrl/users/forgot-password/change";
  static const forgotMpin = "$baseUrl/users/forgot-mpin";
  static const forgotMpinChange = "$baseUrl/users/forgot-mpin/change";
  static const getProfile = "$baseUrl/customer/profile/";
  static const deleteProfile = "$baseUrl/customer/";

  static const listVehicles = "$baseUrl/vehicle/vehicles/?user_id=";
  static const addVehicle = "$baseUrl/vehicle/vehicles/";
  static const vehicleMake = "$baseUrl/makes/makes/";
  static const emissionNorms = "$baseUrl/emission_norms/emission_norms/";
  static const fuelTypes = "$baseUrl/fuel_types/fuel_types/";
  static const vehicleCategories =
      "$baseUrl/vehicle_categories/vehicle_categories/";
  static const vehicleModal = "$baseUrl/modals/modals/";
  static const tyresNumber = "$baseUrl/number_of_tyres/number_of_tyres/";

  static const openTickets = "$baseUrl/ticket/tickets/?customer_id=";
  static const closedTickets = "$baseUrl/ticket/tickets/?customer_id=";

  static const estimateList = "$baseUrl/estimation/estimates/?ticket_id=";
  static const dismantleData = "$baseUrl/dismantle/dismantle/?ticket_id=";
  static const UpdateTicketStatus = "$baseUrl/ticket/tickets/";
  static const vehicleinvestigation =
      "$baseUrl/vehicleinvestigation/vehicle-investigations/?ticket_id=";
  static const notifications = "$baseUrl/assets/notifications?user_id=";
  static const ticketDetail = "$baseUrl/ticket/tickets/";

  // static const profileUrl = "$baseUrl/mechanic/profile/";
  // static const updateProfile = "$baseUrl/profile/";
  // static const sendEstimation = "$baseUrl/estimation/estimates/";
  // static const getEstimation = "$baseUrl/estimation/estimates/";
  // static const patchEstimation = "$baseUrl/estimation/estimates/";
  // static const patchtickets = "$baseUrl/ticket/tickets/";
  // static const uploadDismantle = "$baseUrl/dismantle/dismantle/";
  // static const openTickets = "$baseUrl/ticket/tickets/?mechanic_id=";
  // static const closedTickets = "$baseUrl/ticket/tickets/closed?mechanic_id=";

  // static const ticketUrl = "$baseUrl/ticket/";
}
