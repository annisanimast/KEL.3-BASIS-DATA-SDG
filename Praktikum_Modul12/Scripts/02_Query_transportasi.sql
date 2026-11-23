// Jalankan Query (Aggregation Pipeline)
db.trips.aggregate([
  { $match: { route_id: 12, started_at: { $gte: "2026-11-01" } } },
  { $lookup: { from: "routes", localField: "route_id", foreignField: "route_id", as: "rute" } },
  { $unwind: "$rute" },
  { $project: { _id: 0, trip_id: 1, started_at: 1, route_name: "$rute.route_name" } }
]);
