// Code generated by mockery v2.35.4. DO NOT EDIT.

package mocks

import (
	context "context"

	api "github.com/smartcontractkit/chainlink/v2/core/services/gateway/api"

	mock "github.com/stretchr/testify/mock"
)

// DON is an autogenerated mock type for the DON type
type DON struct {
	mock.Mock
}

// SendToNode provides a mock function with given fields: ctx, nodeAddress, msg
func (_m *DON) SendToNode(ctx context.Context, nodeAddress string, msg *api.Message) error {
	ret := _m.Called(ctx, nodeAddress, msg)

	var r0 error
	if rf, ok := ret.Get(0).(func(context.Context, string, *api.Message) error); ok {
		r0 = rf(ctx, nodeAddress, msg)
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// NewDON creates a new instance of DON. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
// The first argument is typically a *testing.T value.
func NewDON(t interface {
	mock.TestingT
	Cleanup(func())
}) *DON {
	mock := &DON{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}
