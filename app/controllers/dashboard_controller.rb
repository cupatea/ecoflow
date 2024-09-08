class DashboardController < ApplicationController
  def index
    @stats = {
      "bmsMaster.temp"        => "Temperature ℃",
      "bmsMaster.inputWatts"  => "Input power",
      "bmsMaster.outputWatts" => "Output power",
      "bmsMaster.vol"         => "Voltage V",
      "bmsMaster.amp"         => "Current A",
      "inv.inputWatts"        => "Charging power (W)",
      "inv.outputWatts"       => "Discharging power (W)",
      "inv.outTemp"           => "Inverter temperature (℃)",
      "mppt.mpptTemp"         => "MPPT temperature (℃)",
      "mppt.dc24vTemp"        => "DCDC24V temperature (℃)",
      "pd.wattsOutSum"        => "Total output power (W)",
      "pd.wattsInSum"         => "Total input power (W)"
    }


    @data = Device.all.map do |device|
      stats = device.stats.pluck(:created_at, :data)
      [
        device.name,
        @stats.map { |k, _v| [ k, prepare(stats, k) ] }.to_h
      ]
    end
  end

  private

  def prepare(stats, key)
    stats.filter_map do |timestamp, data|
      next unless data.present?

      [ timestamp, data[key] ]
    end
  end
end
