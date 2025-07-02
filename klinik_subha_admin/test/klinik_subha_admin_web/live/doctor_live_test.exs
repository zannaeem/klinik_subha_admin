defmodule KlinikSubhaAdminWeb.DoctorLiveTest do
  use KlinikSubhaAdminWeb.ConnCase

  import Phoenix.LiveViewTest
  import KlinikSubhaAdmin.BookingFixtures

  @create_attrs %{name: "some name", specialization: "some specialization", email: "some email", phone: "some phone"}
  @update_attrs %{name: "some updated name", specialization: "some updated specialization", email: "some updated email", phone: "some updated phone"}
  @invalid_attrs %{name: nil, specialization: nil, email: nil, phone: nil}

  defp create_doctor(_) do
    doctor = doctor_fixture()
    %{doctor: doctor}
  end

  describe "Index" do
    setup [:create_doctor]

    test "lists all doctors", %{conn: conn, doctor: doctor} do
      {:ok, _index_live, html} = live(conn, ~p"/doctors")

      assert html =~ "Listing Doctors"
      assert html =~ doctor.name
    end

    test "saves new doctor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/doctors")

      assert index_live |> element("a", "New Doctor") |> render_click() =~
               "New Doctor"

      assert_patch(index_live, ~p"/doctors/new")

      assert index_live
             |> form("#doctor-form", doctor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#doctor-form", doctor: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/doctors")

      html = render(index_live)
      assert html =~ "Doctor created successfully"
      assert html =~ "some name"
    end

    test "updates doctor in listing", %{conn: conn, doctor: doctor} do
      {:ok, index_live, _html} = live(conn, ~p"/doctors")

      assert index_live |> element("#doctors-#{doctor.id} a", "Edit") |> render_click() =~
               "Edit Doctor"

      assert_patch(index_live, ~p"/doctors/#{doctor}/edit")

      assert index_live
             |> form("#doctor-form", doctor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#doctor-form", doctor: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/doctors")

      html = render(index_live)
      assert html =~ "Doctor updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes doctor in listing", %{conn: conn, doctor: doctor} do
      {:ok, index_live, _html} = live(conn, ~p"/doctors")

      assert index_live |> element("#doctors-#{doctor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#doctors-#{doctor.id}")
    end
  end

  describe "Show" do
    setup [:create_doctor]

    test "displays doctor", %{conn: conn, doctor: doctor} do
      {:ok, _show_live, html} = live(conn, ~p"/doctors/#{doctor}")

      assert html =~ "Show Doctor"
      assert html =~ doctor.name
    end

    test "updates doctor within modal", %{conn: conn, doctor: doctor} do
      {:ok, show_live, _html} = live(conn, ~p"/doctors/#{doctor}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Doctor"

      assert_patch(show_live, ~p"/doctors/#{doctor}/show/edit")

      assert show_live
             |> form("#doctor-form", doctor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#doctor-form", doctor: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/doctors/#{doctor}")

      html = render(show_live)
      assert html =~ "Doctor updated successfully"
      assert html =~ "some updated name"
    end
  end
end
